In-Reply-To: <19990913192231.002595>
Date: Mon, 13 Sep 1999 19:24:03 +0200
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au,
        eek@escape.ca
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: New booter
Message-Id: <19990913192403.030901@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I forgot to mention that the kernel args can be changed by editing the
CMDL resource in the System file with resedit. Don't forget the trailing
0, it's a C string !


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
