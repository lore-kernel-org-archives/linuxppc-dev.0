Message-Id: <200206110426.g5B4QVf26412@mailout5.nyroc.rr.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Patrick Berge <pberge@stny.rr.com>
Reply-To: pberge@stny.rr.com
To: David Edelsohn <dje@watson.ibm.com>
Subject: Re: docs for ppc gnu gcc inline asm?
Date: Tue, 11 Jun 2002 00:26:23 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <200206100348.XAA28254@makai.watson.ibm.com>
In-Reply-To: <200206100348.XAA28254@makai.watson.ibm.com>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sunday 09 June 2002 23:48, David Edelsohn wrote:
> 	GNU as supports all of the PowerPC mnemonics.  The GCC Further
> Readings link on the main page has a list of links for various
> architectures, including the PowerPC Assembler manuals for AIX.  Both IBM,
> Motorola, and Apple all have documentation about the instruction set
> available through their websites.

Thanks the response David , but I was looking for a more inclusive list.  For
example some assembler I have written for the IBM PPC 405 has icbst, mtdcr
and quite a few other 4xx only operations.  Obviously the as has this
information when passed 'mcpu=405'.  I was just hoping I could find a single
source of documentation containing the superset of all IBM
(POWER(2),4xx,6xx,7xx(x), PPC64) and Motorola (8xx(x), 7xx, G3/G4).  Also
book E based processors are in development which will soon only complicate
this matter more for anyone who is not  a PPC assembler expert.

Would be nice if http://www.gnu.org/manual/gas/html_mono/as.html was updated
to include a PPC section.  It currently is dated Jan '94.

Pat

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
