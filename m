Date: Fri, 6 Apr 2001 02:05:59 -0700
From: Matt Porter <mporter@mvista.com>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Torben Mathiasen <torben@kernel.dk>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: eepro100 on IBM Walnut board,
Message-ID: <20010406020559.A27054@cx258813-a.chnd1.az.home.com>
References: <20010405212019.H1475@fry> <20010405143318.E1889@ftsoj.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010405143318.E1889@ftsoj.fsmlabs.com>; from cort@fsmlabs.com on Thu, Apr 05, 2001 at 02:33:18PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 05, 2001 at 02:33:18PM -0600, Cort Dougan wrote:
>
> The latest eepro has serious endian-ness problems.  PPC and MIPS suffer
> this problem.

I'm using the following version (stock 2.4.2) on ten different PPC
platforms (603e, 750's, 8240's):

static const char *version =
"eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/dri
vers/eepro100.html\n"
"eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@s
aw.sw.com.sg> and others\n";

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
