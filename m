Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17351.28313.858572.825928@cargo.ozlabs.ibm.com>
Date: Fri, 13 Jan 2006 20:10:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] powerpc oprofile G4 clashes with wacom driver
In-Reply-To: <43C67B3F.3080301@shadowen.org>
References: <20060112144437.GA15923@shadowen.org>
	<65FBDB60-D4A5-40DF-BA73-AB6388A9368B@kernel.crashing.org>
	<43C67B3F.3080301@shadowen.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Whitcroft writes:

> Paul?  I am ambivalent about the prefix, and it can be trivially changed
> to any that you feel approriate.

I think there needs to be a prefix, but I have no idea what POT_ would
be (oh, I guess it's Powerpc Oprofile Type, I suppose).  Something
like PPC_OPROFILE_ would be better, if it's not too long.

Paul.
