Return-Path: <npiggin@gmail.com>
Date: Sat, 3 Feb 2018 14:31:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: skiboot@lists.ozlabs.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH (skiboot)] dt: add /cpus/ibm,powerpc-cpu-features device
 tree bindings
Message-ID: <20180203143109.29dad410@roar.ozlabs.ibm.com>
In-Reply-To: <20180203042732.27980-1-npiggin@gmail.com>
References: <20180203042732.27980-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat,  3 Feb 2018 14:27:32 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:


> diff --git a/core/cpufeatures.c b/core/cpufeatures.c
> new file mode 100644
> index 000000000..ca9df91f0
> --- /dev/null
> +++ b/core/cpufeatures.c
> @@ -0,0 +1,932 @@
> +/* Copyright 2017 IBM Corp.
> + *
> + * Licensed under the Apache License, Version 2.0 (the "License");
> + * you may not use this file except in compliance with the License.
> + * You may obtain a copy of the License at
> + *
> + * 	http://www.apache.org/licenses/LICENSE-2.0
> + *
> + * Unless required by applicable law or agreed to in writing, software
> + * distributed under the License is distributed on an "AS IS" BASIS,
> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
> + * implied.
> + * See the License for the specific language governing permissions and
> + * limitations under the License.
> + */
> +
> +/*
> + * This file deals with setup of /cpus/ibm,powerpc-cpu-features dt
> + */
> +
> +#include <skiboot.h>
> +#include <cpu.h>
> +#include <processor.h>
> +#include <ccan/str/str.h>
> +#include <device.h>
> +
> +#define DEBUG

Sorry, didn't send the right version after testing. This line should be
deleted before going upstream.

Thanks,
Nick
