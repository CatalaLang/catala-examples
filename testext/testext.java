/* This is a template file following the expected interface and declarations to
 * implement the corresponding Catala module.
 *
 * You should replace all `Error.Impossible` place-holders with your
 * implementation and rename it to remove the ".template" suffix. */

import catala.runtime.*;
import catala.runtime.exception.*;
import catala.stdlib.*;

import org.yaml.snakeyaml.*;

public class Testext {
    
    public static class Globals {
        
        public static final CatalaArray<CatalaPosition> loc =
            new CatalaArray<CatalaPosition>
             (new CatalaPosition("testext/testext.catala_en", 4, 13, 4, 16));
        
        public static final CatalaFunction<CatalaInteger,CatalaInteger> fun =
            x -> {
            return x;
            };
    }
    
}
