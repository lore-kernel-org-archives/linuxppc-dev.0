Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17304.63219.580281.900406@cargo.ozlabs.ibm.com>
Date: Fri, 9 Dec 2005 14:16:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Tjernlund" <tjernlund@tjernlund.se>
In-Reply-To: <000e01c5fc4c$25b17cb0$020120ac@Jocke>
References: <000e01c5fc4c$25b17cb0$020120ac@Jocke>
Cc: Linuxppc-Dev <linuxppc-dev@ozlabs.org>, 'Linh Dang' <linhd@nortel.com>,
	uclibc@uclibc.org
Subject: Re: Linux process ABI broken in 2.6?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tjernlund writes:

> Secion 8.4.1 in
> http://refspecs.freestandards.org/LSB_3.1.0/LSB-Core-PPC32/LSB-Core-PPC32.html#PROCESSINITIALIZATION
> 
> says:
> "Contrary to what is stated in the Registers part of chapter 3 of the System V Application Binary Interface PowerPC Processor
> Supplement there are no values set in registers r3, r4, r5, r6 and r7. Instead the values specified to appear in all of those
> registers except r7 are placed on the stack. The value to be placed into register r7, the termination function pointer is not passed
> to the process."
> 
> How do one not pass a termination function in r7 other than setting
> r7 to zero?

"Not passed" means that there is no value provided in any register or
word of memory that should be taken to be the address of a termination
function.

Paul.
