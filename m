Message-ID: <3A648075.5093ADAD@raleigh.ibm.com>
Date: Tue, 16 Jan 2001 12:10:13 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: frowand@mvista.com, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com> <3A63BAFB.80E3980C@mvista.com> <3A643283.A20200E8@raleigh.ibm.com> <3A647BC7.15F669F3@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------554DCBF0614BA50A52687995"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------554DCBF0614BA50A52687995
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan,

Thanks for the info.  I agree that Pinned tlbs could be maintence
headache with each 4xx/8xx
chip requiring a different set of pinned tlbs.

Chip

Dan Malek wrote:
>
> Ralph Blach wrote:
> >
> > Why do we need simulated bat registers.
>
> To improve performance.  Right now, on the 4xx there is the
> concept of "pinned" TLB entries to reduce/eliminate TLB misses
> on large mapped areas (like kernel text/data or I/O).  The 8xx
> does this in some custom applications as well.  These are just
> hacks that are headed down a disastrous maintenance path that
> need to be stopped now for a more generic solution.
>
> I have been experimenting with many different methods of using
> the "large" page table sizes through the generic memory management
> methods that already exist in the kernel.  I believe I can wrap
> the concept of the pinned TLB entries into the same logic as BAT
> register management on the bigger processors.  Hence, I call them
> simulated BAT registers....the semantics aren't quite the same.
>
> The BAT registers are a really good thing, and although the large
> page size TLB entries are more flexible, they require more software
> overhead.  I would like to make some generic Linux MM modifications
> to help us support variable page sizes, but I suspect that will
> never happen.
>
>         -- Dan
>
--------------554DCBF0614BA50A52687995
Content-Type: text/x-vcard; charset=us-ascii;
 name="rcblach.vcf"
Content-Description: Card for Ralph Blach
Content-Disposition: attachment;
 filename="rcblach.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
n:Blach;Ralph
tel;work:919-543-1207
x-mozilla-html:TRUE
url:www.ibm.com
org:IBM MicroElectronics
adr:;;3039 Cornwallis		;RTP;NC;27709;USA
version:2.1
email;internet:rcblach@raleigh.ibm.com
x-mozilla-cpt:;15936
fn:Ralph Blach
end:vcard

--------------554DCBF0614BA50A52687995--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
