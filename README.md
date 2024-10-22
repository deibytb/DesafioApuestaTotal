### Desafío Técnico: Visualización de Apuestas (iOS)

**Objetivo**: Desarrolla una app en iOS con **Swift** para visualizar una lista de apuestas con la información proporcionada. Aplica diferentes estilos según el nivel de cada apuesta.

### **Requisitos**:

1. **Visualización diseño de apuestas por Nivel**:

   - Muestra las apuestas con el diseño que prefieras (**cards**, **listas**, etc.), usando **UIKit** o **SwiftUI**.
   - Estiliza las apuestas según su **nivel**, siguiendo esta jerarquía:
     - **Ganadas**: Leyenda, King, Master, Capo, Cazafijas.
     - **Perdidas**: Donatelo.

2. **Componentes Clave**:

   - **Logo**.
   - **Campo de búsqueda** para buscar por **EventName** (se encuentra en `BetSelections`), usando un **UISearchBar** (en **UIKit**) o **SearchField** (en **SwiftUI**).
   - **Filtro** que permita filtrar por algún criterio relevante (por ejemplo, **status** o **tipo de apuesta**).

3. **Diseño y Estilo**:

   - Usa **Storyboard** y **Auto Layout** (si estás utilizando **UIKit**) o **SwiftUI** para diseñar las vistas.
   - Los estilos y colores dependen de ti, pero asegúrate de que cada nivel sea fácilmente identificable.

4. **Transiciones y Animaciones**:

   - Se valoran las animaciones y transiciones suaves en la interfaz. Usa **UIView animations** en **UIKit** o **withAnimation** en **SwiftUI**.

5. **Informacion de las apuestas**:

   - **betsAll.json** es un archivo con los detalles MINIMOS de la apuesta.
   - **betsDetailsAll.json** es un archivo con los detalles COMPLETOS de la apuesta.
   - En **betsDetailsAll.json** encontrarás una propiedad **BetSelections** (Selección principal de apuesta).
   - En **betsDetailsAll.json** encontrarás una propiedad **BBSelections** opcional que podría o no estar dentro de un **BetSelections** (Subselección dentro de una selección de apuesta).

   ```swift
   // Ejemplo:

   struct BetHistory1 {
       var BetSelections: [BetSelection]
       // BBSelections puede o no estar presente
   }

   struct BetSelection {
       var BBSelections: [BBSelection]?
   }
   ```

6. **Cruce de Datos**:

   - Cruza la información de **betsAll.json** (campo `game`) con **betsDetailsAll.json** (campo `BetId`).

7. **Flujos adicionales extras opcionales valorados**:

   - Funcionalidad Login
   - Funcionalidad de **tema oscuro/claro**: detectar si el sistema está en modo oscuro o claro y ajustar los estilos de la app.

### **Datos Importantes**:

- Estos datos representan el **historial de apuestas de un usuario real**.
- Se evaluará la claridad en el diseño, la funcionalidad de búsqueda y filtrado, así como las animaciones.
- Cualquier flujo o vista adicional que desees incluir, como una página inicial de login para demostrar habilidades de seguridad, será valorado por el equipo durante la evaluación final.
