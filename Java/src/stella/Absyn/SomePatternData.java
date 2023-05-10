// File generated by the BNF Converter (bnfc 2.9.4.1).

package stella.Absyn;

public class SomePatternData  extends PatternData {
  public final Pattern pattern_;
  public int line_num, col_num, offset;
  public SomePatternData(Pattern p1) { pattern_ = p1; }

  public <R,A> R accept(stella.Absyn.PatternData.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(java.lang.Object o) {
    if (this == o) return true;
    if (o instanceof stella.Absyn.SomePatternData) {
      stella.Absyn.SomePatternData x = (stella.Absyn.SomePatternData)o;
      return this.pattern_.equals(x.pattern_);
    }
    return false;
  }

  public int hashCode() {
    return this.pattern_.hashCode();
  }


}