In-Reply-To: <19991012093430.A11721@warg.uwaterloo.ca>
Date: Tue, 12 Oct 1999 15:44:27 +0200
To: Chris McKillop <cdm@debian.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Apple's iBook Specs
Message-Id: <19991012154427.017386@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 12, 1999, Chris McKillop <cdm@debian.org> wrote:

>	What is most interesting is that the AirPort is on the ATA bus that
>the CDROM sits on.  Some neat 3rd party expansion options come to mind. :)

Not a big surprise. There are a lot of similarities between an ATA and a
16 bits PCCard bus. And I beleive they have a dbdma channel just behind
it, so basically, this stuff might work a lot like a good old ISA
ethernet chip ;)


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
