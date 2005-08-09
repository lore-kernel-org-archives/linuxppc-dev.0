Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <3F1564F6-3732-403B-BA6B-BFAB28568AEE@freescale.com>
References: <dc3d7701e701266ffe852acf4da127ed@kernel.crashing.org>
	<3F1564F6-3732-403B-BA6B-BFAB28568AEE@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <265a318e3c20a3ba217e374d12a8f9f6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 9 Aug 2005 17:16:05 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Joel Schopp <jschopp@austin.ibm.com>, linuxppc64-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I was under the impression that ALL platforms regardless if the had a 
> OF firmware or not would be using a flattened device tree.  Any 
> conversion between an OF tree to a flatten tree would end up happening 
> in boot wrapper code going forward.

Ah OK -- so part of the problem is indeed terminology
confusion.  I view the "boot wrapper code" (prom_init.c)
as being part of the kernel.

Another thing is that I do not want prom_init to kill
OF at all, which means you cannot have a static device
tree.  But that is another fight ;-)


Segher
