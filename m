Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [git pull] Please pull abiv2 branch
In-Reply-To: <535E6804.5050508@linux.vnet.ibm.com>
References: <20140423124902.5be9dab0@kryten>
 <535E6804.5050508@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 10:03:57 +0930
Message-ID: <877g69t1my.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: philippe.bergheaud@fr.ibm.com, mikey@neuling.org, amodra@gmail.com,
 rostedt@goodmis.org, ulrich.weigand@de.ibm.com, mjw@linux.vnet.ibm.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Philippe Bergheaud <felix@linux.vnet.ibm.com> writes:
> Anton Blanchard wrote:
>> Here are the ABIv2 patches rebased against 3.15-rc2.
>
> After recompiling 3.15-rc2 with the ABIv2 patches,
> I see the following line in Modules.symvers:
>
>      0x00000000 TOC. vmlinux EXPORT_SYMBOL
>
> Kernel will not load modules because TOC. has no CRC.
> Is this expected ? Shouldn't TOC. have a CRC ?

What happens when you try to load a module?  It should work...

Cheers,
Rusty.
