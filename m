Return-Path: <halesh.sadashiv@ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] remove bogus ppc_select syscall
Date: Mon, 13 Oct 2008 17:48:09 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D5F6F60@insardxms01.ap.sony.com>
From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	"Paul Mackerras" <paulus@samba.org>, <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




>>Please don't apply Arnd's patch.  As I said, all we need is this
>>one-line change in arch/powerpc/include/asm/systbl.h:
>>
>>-SYSX_SPU(sys_select,ppc32_select,ppc_select)
>>+SYSX_SPU(sys_select,ppc32_select,sys_select)
>
>
>I have tested the testcase that I have provided at the time of
reporting
>this issue. But it didn't work as expected with the above patch you
>provided.
>(Failed to return EINVAL on negative value of n to select())
>
>Please let me know about this. I have tested on PPC32 2.6.23.

Hi all,

Apologies, Test failed because of small typo in test case, The above
patch provided has been tested on PPC32. Works fine and as expected.

Reported-by: Halesh Sadashiv <halesh.sadashiv@ap.sony.com>
Tested-by: Halesh Sadashiv <halesh.sadashiv@ap.sony.com>

Thanks,
Halesh


>
>-Halesh
>
>>
>>Paul.



-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
