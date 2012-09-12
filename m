Return-Path: <bigeasy@linutronix.de>
Message-ID: <5050E965.5080405@linutronix.de>
Date: Wed, 12 Sep 2012 21:58:29 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Cyril Chemparathy <cyril@ti.com>
Subject: Re: [PATCH] of: specify initrd location using 64-bit
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
 <5050CE33.9060909@ti.com>
In-Reply-To: <5050CE33.9060909@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-mips@linux-mips.org, x86@kernel.org, a-jacquiot@ti.com,
 mahesh@linux.vnet.ibm.com, linus.walleij@linaro.org,
 paul.gortmaker@windriver.com, paulus@samba.org, hpa@zytor.com,
 m.szyprowski@samsung.com, jonas@southpole.se, linux@arm.linux.org.uk,
 linux-c6x-dev@linux-c6x.org, nico@linaro.org, david.daney@cavium.com,
 mingo@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>, suzuki@in.ibm.com,
 linux@openrisc.net, arnd@arndb.de, microblaze-uclinux@itee.uq.edu.au,
 devicetree-discuss@lists.ozlabs.org, msalter@redhat.com,
 rob.herring@calxeda.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, blogic@openwrt.org, dhowells@redhat.com,
 monstr@monstr.eu, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 tj@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2012 08:02 PM, Cyril Chemparathy wrote:
>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>> unsigned long end)
>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>
>> Why not phys_addr_t?
>>
>
> The rest of the memory specific bits of the device-tree code use u64 for
> addresses, and I kept it the same for consistency.

Geert is right here. If it is a physical address, it should be
phys_addr_t.

Sebastian
