Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18454.44365.719572.654726@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 15:08:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [RESEND][PATCH 1/2][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
In-Reply-To: <20080428232855.22c13830@lappy.seanm.ca>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428214711.240419c3@lappy.seanm.ca>
	<20080428232855.22c13830@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <sean.maclennan@ottawa.kanatek.ca>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It doesn't help that both of these patches have the same subject line,
nor that it starts with "Re:". :(

Also, I find the statement "A change to the dts to get gpios correct
broke the led code" a bit opaque.  It doesn't tell me in what way it
was broken or what this patch does to correct, or even what the change
was in enough detail that I could find the change in the git
repository.

Paul.
