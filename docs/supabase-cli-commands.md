# Supabase CLI Commands Reference

## Type Generation

### Generate Types from Remote Database

```bash
# Using project ID
npx supabase gen types typescript --project-id xfkhehunhcqqrsgomewy > types/supabase.ts

# Or use npm script
npm run types:generate
```

### Generate Types from Local Database (Future)

```bash
# If running Supabase locally
npx supabase gen types typescript --local > types/supabase.ts
```

## Useful Commands

### Check CLI Version

```bash
npx supabase --version
```

### Login to Supabase (if needed)

```bash
npx supabase login
```

### Link to Remote Project

```bash
npx supabase link --project-ref xfkhehunhcqqrsgomewy
```

## Environment Variables Required

- `NEXT_PUBLIC_SUPABASE_URL` - Project URL
- `NEXT_PUBLIC_SUPABASE_ANON_KEY` - Public anon key
- `SUPABASE_SERVICE_ROLE_KEY` - Service role key (for admin operations)

## Notes

- Types are auto-generated from database schema
- Re-run `npm run types:generate` after database schema changes
- Generated types are saved to `types/supabase.ts`
