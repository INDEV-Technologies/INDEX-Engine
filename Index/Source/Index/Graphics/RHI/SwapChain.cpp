#include "Precompiled.h"
#include "SwapChain.h"

namespace Index
{
    namespace Graphics
    {
        SwapChain* (*SwapChain::CreateFunc)(uint32_t, uint32_t) = nullptr;

        SwapChain* SwapChain::Create(uint32_t width, uint32_t height)
        {
            INDEX_ASSERT(CreateFunc, "No SwapChain Create Function");

            return CreateFunc(width, height);
        }
    }
}
