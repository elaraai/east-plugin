# East UI API Reference

Complete component signatures, props, and style types. For comprehensive documentation, see [USAGE.md](../USAGE.md).

---

## Table of Contents

- [Core Types](#core-types)
- [Style Types](#style-types)
- [Layout Components](#layout-components)
- [Typography Components](#typography-components)
- [Button Components](#button-components)
- [Form Components](#form-components)
- [Collection Components](#collection-components)
- [Chart Components](#chart-components)
- [Display Components](#display-components)
- [Feedback Components](#feedback-components)
- [Disclosure Components](#disclosure-components)
- [Overlay Components](#overlay-components)
- [Container Components](#container-components)
- [State Management](#state-management)

---

## Core Types

| Type | Definition |
|------|------------|
| `UIComponentType` | Recursive `VariantType` representing any UI component |
| `UIComponentArrayType` | `ArrayType(UIComponentType)` - array of components |

---

## Style Types

| Type | Values |
|------|--------|
| `SizeType` | `xs`, `sm`, `md`, `lg`, `xl` |
| `ColorSchemeType` | `gray`, `red`, `orange`, `yellow`, `green`, `teal`, `blue`, `cyan`, `purple`, `pink` |
| `FontWeightType` | `normal`, `medium`, `semibold`, `bold`, `light` |
| `FontStyleType` | `normal`, `italic` |
| `TextAlignType` | `left`, `center`, `right`, `justify` |
| `TextDecorationTypes` | `none`, `underline`, `overline`, `line-through` |
| `FlexDirectionType` | `row`, `column`, `row-reverse`, `column-reverse` |
| `JustifyContentType` | `flex-start`, `flex-end`, `center`, `space-between`, `space-around`, `space-evenly` |
| `AlignItemsType` | `flex-start`, `flex-end`, `center`, `baseline`, `stretch` |
| `FlexWrapType` | `nowrap`, `wrap`, `wrap-reverse` |
| `DisplayType` | `block`, `inline`, `inline-block`, `flex`, `inline-flex`, `grid`, `inline-grid`, `none` |
| `OrientationType` | `horizontal`, `vertical` |
| `OverflowType` | `visible`, `hidden`, `scroll`, `auto` |
| `BorderStyleType` | `solid`, `dashed`, `dotted`, `double`, `none` |
| `TextTransformType` | `uppercase`, `lowercase`, `capitalize`, `none` |

---

## Layout Components

### Box

```typescript
Box.Root(children: UIComponentType[], props?: BoxProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `padding`, `p` | `string` | Padding (e.g., "4", "6") |
| `margin`, `m` | `string` | Margin |
| `bg` | `string` | Background color |
| `width`, `height` | `string` | Dimensions |
| `borderRadius` | `string` | Border radius |
| `display` | `DisplayType` | Display mode |

### Flex

```typescript
Flex.Root(children: UIComponentType[], props?: FlexProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `direction` | `FlexDirectionType` | Flex direction |
| `justify` | `JustifyContentType` | Justify content |
| `align` | `AlignItemsType` | Align items |
| `wrap` | `FlexWrapType` | Flex wrap |
| `gap` | `string` | Gap between children |

### Stack

```typescript
Stack.Root(children: UIComponentType[], props?: StackProps): UIComponentType
Stack.HStack(children: UIComponentType[], props?: StackProps): UIComponentType
Stack.VStack(children: UIComponentType[], props?: StackProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `direction` | `FlexDirectionType` | Stack direction |
| `gap` | `string` | Gap between items |
| `align` | `AlignItemsType` | Cross-axis alignment |
| `justify` | `JustifyContentType` | Main-axis alignment |

### Grid

```typescript
Grid.Root(children: UIComponentType[], props?: GridProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `templateColumns` | `string` | CSS grid-template-columns |
| `templateRows` | `string` | CSS grid-template-rows |
| `gap` | `string` | Grid gap |

### Separator

```typescript
Separator.Root(props?: SeparatorProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `orientation` | `OrientationType` | horizontal/vertical |
| `size` | `SizeType` | Separator thickness |

### Splitter

```typescript
Splitter.Root(panels: SplitterPanel[], props?: SplitterProps): UIComponentType
```

---

## Typography Components

### Text

```typescript
Text.Root(content: string | StringExpr, props?: TextProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `fontSize` | `string` | Font size (xs, sm, md, lg, xl, 2xl, etc.) |
| `fontWeight` | `FontWeightType` | Font weight |
| `fontStyle` | `FontStyleType` | Font style |
| `color` | `string` | Text color |
| `textAlign` | `TextAlignType` | Text alignment |
| `textDecoration` | `TextDecorationType` | Text decoration |

### Heading

```typescript
Heading.Root(content: string | StringExpr, props?: HeadingProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `size` | `string` | Size (h1, h2, h3, h4, h5, h6, or xl, lg, md, sm) |
| `fontWeight` | `FontWeightType` | Font weight |

### Code

```typescript
Code.Root(content: string | StringExpr, props?: CodeProps): UIComponentType
```

### CodeBlock

```typescript
CodeBlock.Root(code: string, props?: CodeBlockProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `language` | `string` | Syntax highlight language |
| `showLineNumbers` | `boolean` | Show line numbers |

### Link

```typescript
Link.Root(content: string | StringExpr, props?: LinkProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `href` | `string` | URL |
| `isExternal` | `boolean` | Open in new tab |

### List

```typescript
List.Ordered(items: string[] | UIComponentType[], props?: ListProps): UIComponentType
List.Unordered(items: string[] | UIComponentType[], props?: ListProps): UIComponentType
```

---

## Button Components

### Button

```typescript
Button.Root(label: string | StringExpr, props?: ButtonProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `variant` | `VariantType` | solid, outline, ghost, subtle |
| `colorPalette` | `ColorSchemeType` | Button color |
| `size` | `SizeType` | Button size |
| `isDisabled` | `boolean` | Disabled state |
| `isLoading` | `boolean` | Loading state |
| `leftIcon` | `UIComponentType` | Left icon |
| `rightIcon` | `UIComponentType` | Right icon |
| `onClick` | `($: BlockBuilder) => void` | Click handler |

### IconButton

```typescript
IconButton.Root(icon: string | UIComponentType, props?: IconButtonProps): UIComponentType
```

---

## Form Components

### Input

```typescript
Input.String(value: StringExpr, props?: InputProps): UIComponentType
Input.Integer(value: IntegerExpr, props?: InputProps): UIComponentType
Input.Float(value: FloatExpr, props?: InputProps): UIComponentType
Input.DateTime(value: DateTimeExpr, props?: InputProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `placeholder` | `string` | Placeholder text |
| `size` | `SizeType` | Input size |
| `variant` | `VariantType` | outline, filled, flushed |
| `isDisabled` | `boolean` | Disabled state |
| `isReadOnly` | `boolean` | Read-only state |
| `onChange` | `($: BlockBuilder, value: Expr) => void` | Change handler |
| `onBlur` | `($: BlockBuilder, value: Expr) => void` | Blur handler |

### Select

```typescript
Select.Root(options: SelectOption[], props?: SelectProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `value` | `Expr` | Selected value |
| `placeholder` | `string` | Placeholder text |
| `onChange` | `($: BlockBuilder, value: Expr) => void` | Change handler |

### Checkbox

```typescript
Checkbox.Root(props?: CheckboxProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `isChecked` | `BooleanExpr` | Checked state |
| `label` | `string` | Label text |
| `onChange` | `($: BlockBuilder, checked: BooleanExpr) => void` | Change handler |

### Switch

```typescript
Switch.Root(props?: SwitchProps): UIComponentType
```

### Slider

```typescript
Slider.Root(props?: SliderProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `value` | `FloatExpr \| IntegerExpr` | Current value |
| `min` | `number` | Minimum value |
| `max` | `number` | Maximum value |
| `step` | `number` | Step increment |
| `onChange` | `($: BlockBuilder, value: Expr) => void` | Change handler |

### Field

```typescript
Field.Root(input: UIComponentType, props?: FieldProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `label` | `string` | Field label |
| `helperText` | `string` | Helper text |
| `errorText` | `string` | Error message |
| `isRequired` | `boolean` | Required field |
| `isInvalid` | `boolean` | Invalid state |

### Textarea

```typescript
Textarea.Root(value: StringExpr, props?: TextareaProps): UIComponentType
```

### FileUpload

```typescript
FileUpload.Root(props?: FileUploadProps): UIComponentType
```

### TagsInput

```typescript
TagsInput.Root(props?: TagsInputProps): UIComponentType
```

---

## Collection Components

### Table

```typescript
Table.Root<T>(
    data: T[],
    columns: TableColumn<T>[],
    props?: TableProps
): UIComponentType
```

| Column Prop | Type | Description |
|-------------|------|-------------|
| `header` | `string` | Column header |
| `accessorKey` | `keyof T` | Data key |
| `cell` | `(row: T) => UIComponentType` | Custom cell renderer |

| Table Prop | Type | Description |
|------------|------|-------------|
| `variant` | `TableVariantType` | simple, line, outline |
| `showColumnBorder` | `boolean` | Show column borders |
| `striped` | `boolean` | Striped rows |
| `onRowClick` | `($: BlockBuilder, row: T) => void` | Row click handler |

### DataList

```typescript
DataList.Root(items: DataListItem[], props?: DataListProps): UIComponentType
```

### TreeView

```typescript
TreeView.Root(nodes: TreeNode[], props?: TreeViewProps): UIComponentType
```

### Gantt

```typescript
Gantt.Root(tasks: GanttTask[], props?: GanttProps): UIComponentType
```

### Planner

```typescript
Planner.Root(events: PlannerEvent[], props?: PlannerProps): UIComponentType
```

---

## Chart Components

### Line Chart

```typescript
Chart.Line<T>(
    data: T[],
    series: Record<string, SeriesConfig>,
    props?: LineChartProps
): UIComponentType

Chart.LineMulti<T>(
    dataSets: { data: T[], seriesKey: string }[],
    series: Record<string, SeriesConfig>,
    props?: LineChartProps
): UIComponentType
```

### Bar Chart

```typescript
Chart.Bar<T>(data: T[], series: Record<string, SeriesConfig>, props?: BarChartProps): UIComponentType
Chart.BarMulti<T>(...): UIComponentType
```

### Area Chart

```typescript
Chart.Area<T>(data: T[], series: Record<string, SeriesConfig>, props?: AreaChartProps): UIComponentType
Chart.AreaMulti<T>(...): UIComponentType
```

### Scatter Chart

```typescript
Chart.Scatter<T>(data: T[], series: Record<string, SeriesConfig>, props?: ScatterChartProps): UIComponentType
Chart.ScatterMulti<T>(...): UIComponentType
```

### Pie Chart

```typescript
Chart.Pie<T>(data: T[], props?: PieChartProps): UIComponentType
```

### Radar Chart

```typescript
Chart.Radar<T>(data: T[], series: Record<string, SeriesConfig>, props?: RadarChartProps): UIComponentType
```

### BarList / BarSegment

```typescript
Chart.BarList(data: BarListItem[], props?: BarListProps): UIComponentType
Chart.BarSegment(data: BarSegmentItem[], props?: BarSegmentProps): UIComponentType
```

### Sparkline

```typescript
Sparkline(data: number[], props?: SparklineProps): UIComponentType
```

**Chart Props (common):**

| Prop | Type | Description |
|------|------|-------------|
| `xAxis` | `{ dataKey: string, label?: string }` | X-axis config |
| `yAxis` | `{ label?: string }` | Y-axis config |
| `showLegend` | `boolean` | Show legend |
| `showGrid` | `boolean` | Show grid lines |
| `showDots` | `boolean` | Show data points |
| `height` | `number` | Chart height |

---

## Display Components

### Badge

```typescript
Badge.Root(label: string, props?: BadgeProps): UIComponentType
```

### Tag

```typescript
Tag.Root(label: string, props?: TagProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `colorPalette` | `ColorSchemeType` | Tag color |
| `closable` | `boolean` | Show close button |
| `onClose` | `($: BlockBuilder) => void` | Close handler |

### Avatar

```typescript
Avatar.Root(props?: AvatarProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `name` | `string` | User name (for initials) |
| `src` | `string` | Image URL |
| `size` | `SizeType` | Avatar size |

### Icon

```typescript
Icon.Root(name: string, props?: IconProps): UIComponentType
```

### Stat

```typescript
Stat.Root(props?: StatProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `label` | `string` | Stat label |
| `value` | `string \| number` | Stat value |
| `change` | `number` | Change percentage |
| `changeType` | `increase \| decrease` | Change direction |

---

## Feedback Components

### Alert

```typescript
Alert.Root(props?: AlertProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `status` | `info \| success \| warning \| error` | Alert status |
| `title` | `string` | Alert title |
| `description` | `string` | Alert description |

### Progress

```typescript
Progress.Root(props?: ProgressProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `value` | `number` | Progress value (0-100) |
| `colorPalette` | `ColorSchemeType` | Progress color |
| `size` | `SizeType` | Progress size |
| `type` | `linear \| circular` | Progress type |

---

## Disclosure Components

### Accordion

```typescript
Accordion.Root(items: AccordionItem[], props?: AccordionProps): UIComponentType
```

### Tabs

```typescript
Tabs.Root(tabs: TabItem[], props?: TabsProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `variant` | `line \| enclosed \| soft-rounded` | Tab style |
| `defaultIndex` | `number` | Default active tab |

### Carousel

```typescript
Carousel.Root(slides: UIComponentType[], props?: CarouselProps): UIComponentType
```

---

## Overlay Components

### Dialog

```typescript
Dialog.Root(props: DialogProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `trigger` | `UIComponentType` | Trigger element |
| `title` | `string` | Dialog title |
| `children` | `UIComponentType[]` | Dialog content |
| `footer` | `UIComponentType[]` | Footer actions |
| `size` | `SizeType` | Dialog size |

### Drawer

```typescript
Drawer.Root(props: DrawerProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `trigger` | `UIComponentType` | Trigger element |
| `placement` | `left \| right \| top \| bottom` | Drawer position |
| `children` | `UIComponentType[]` | Drawer content |

### Popover

```typescript
Popover.Root(props: PopoverProps): UIComponentType
```

### Tooltip

```typescript
Tooltip.Root(props: TooltipProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `trigger` | `UIComponentType` | Trigger element |
| `content` | `string \| UIComponentType` | Tooltip content |
| `placement` | `string` | Tooltip position |

### Menu

```typescript
Menu.Root(props: MenuProps): UIComponentType
```

### HoverCard

```typescript
HoverCard.Root(props: HoverCardProps): UIComponentType
```

### ActionBar

```typescript
ActionBar.Root(props: ActionBarProps): UIComponentType
```

### ToggleTip

```typescript
ToggleTip.Root(props: ToggleTipProps): UIComponentType
```

---

## Container Components

### Card

```typescript
Card.Root(props?: CardProps): UIComponentType
```

| Prop | Type | Description |
|------|------|-------------|
| `header` | `UIComponentType` | Card header |
| `children` | `UIComponentType[]` | Card body |
| `footer` | `UIComponentType` | Card footer |
| `variant` | `elevated \| outline \| filled` | Card style |

---

## State Management

### State.readTyped

```typescript
State.readTyped<T>(key: StringExpr, type: T): AsyncPlatformFunction<[], OptionType<T>>
```

Read typed state value. Returns `OptionType` (some/none).

### State.writeTyped

```typescript
State.writeTyped<T>(key: StringExpr, value: OptionType<T>, type: T): AsyncPlatformFunction<[], NullType>
```

Write typed state value. Pass `variant("none", null)` to delete.

### State.initTyped

```typescript
State.initTyped<T>(key: StringExpr, value: T, type: T): AsyncPlatformFunction<[], NullType>
```

Initialize state only if key doesn't exist.

### State.has

```typescript
State.has(key: StringExpr): AsyncPlatformFunction<[], BooleanType>
```

Check if key exists in state.

### State.Implementation

Platform implementation array for `East.compileAsync()`.

```typescript
const compiled = East.compileAsync(myComponent.toIR(), State.Implementation);
```
