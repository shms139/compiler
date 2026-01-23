    //TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
    // click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
    import compiler.ast.nodes.html.TextNode;
    import compiler.ast.nodes.html.*;
    import compiler.ast.nodes.css.*;
    import compiler.ast.nodes.python.*;
    import compiler.ast.nodes.jinja.*;
    import compiler.ast.visitors.PrintVisitor;
    
    public class Main {
        public static void main(String[] args) {
            //TIP Press <shortcut actionId="ShowIntentionActions"/> with your caret at the highlighted text
            // to see how IntelliJ IDEA suggests fixing it.
    
                    // ===== HTML =====
                    HtmlElementNode html = new HtmlElementNode("html", 1);
                    HtmlElementNode body = new HtmlElementNode("body", 2);
                    html.addChild(body);
    
                    // نص داخل body
                    TextNode text = new TextNode("Hello World", 3);
                    body.addChild(text);
    
                    // ===== CSS =====
                    CssStylesheetNode css = new CssStylesheetNode(4);
                    CssRuleNode rule = new CssRuleNode("body", 4);
                    CssDeclarationNode decl = new CssDeclarationNode("color", "red", 4);
                    rule.addChild(decl);
                    css.addChild(rule);
                    html.addChild(css);
    
                    // ===== Python =====
                    PythonAssignmentNode assign = new PythonAssignmentNode(5);
                    PythonExprNode expr = new PythonExprNode(5);
                    assign.addChild(expr);
                    body.addChild(assign);
    
                    // ===== Jinja =====
                    JinjaExprNode jinjaExpr = new JinjaExprNode(6);
                    body.addChild(jinjaExpr);
    
                    // ===== Print AST =====
                    PrintVisitor visitor = new PrintVisitor();
                    visitor.printTree(html);
    
    
        }
    
    
    
    
    }