Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18403.32257.725539.470771@cargo.ozlabs.ibm.com>
Date: Fri, 21 Mar 2008 20:21:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
In-Reply-To: <fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely writes:

> Personally, I'm not fond of this approach.  There is already some
> traction to using the reg-shift property to specify spacing, and I
> think it would be appropriate to also define a reg-offset property to
> handle the +3 offset and then let the xilinx 16550 nodes use those.

Why do we need a reg-offset property when we can just add the offset
to the appropriate word(s) in the reg property?

Paul.
