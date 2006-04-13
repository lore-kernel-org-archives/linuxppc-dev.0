Return-Path: <mikey@ozlabs.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
In-reply-to: <9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com> 
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
Date: Thu, 13 Apr 2006 15:36:20 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060413053614.2648467DE3@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Jimi,

> > NOTE: that the dtc must also not generate the blob reservation
> > entry.
> 
> This reservation is only generated for "asm" dtc targets so it is  
> only that case that need to be changed.

The user space kexec tools create a reserve map entry for the blob as
well.  

Mikey
