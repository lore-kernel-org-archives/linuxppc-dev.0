Message-ID: <32823.217.46.152.98.1078474779.squirrel@www.solinno.co.uk>
In-Reply-To: <20040228153359.GP1052@smtp.west.cox.net>
References: <1180.80.7.99.14.1077956583.squirrel@www.solinno.co.uk>
    <20040228003259.3dd5c25a.akpm@osdl.org>
    <1275.80.7.99.14.1077957786.squirrel@www.solinno.co.uk>
    <20040228153359.GP1052@smtp.west.cox.net>
Date: Fri, 5 Mar 2004 08:19:39 -0000 (GMT)
Subject: Re: Please revert "use todc time functions for PPC_PREP" changeset
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Andrew Morton" <akpm@osdl.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	"Tom Rini" <trini@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini said:
> On Sat, Feb 28, 2004 at 08:43:06AM -0000, Leigh Brown wrote:
>> Andrew Morton said:
>> >
>> > "Leigh Brown" <leigh@solinno.co.uk> wrote:
>> >>  Your patch (ChangeSet@1.1557.41.25) breaks the 43p140 and Carolina,
>> and
>> >>  probably quite a few other RS/6000 based PRePs.  I was a bit
>> surprised
>> >>  to see it 2.6.3.
>> >>
>> >>  http://linux.bkbits.net:8080/linux-2.5/patch@1.1557.41.25?nav=index.html|ChangeSet@-3w|cset@1.1557.41.25
>> >>
>> >>  Can we revert this until there is a working version, please?
>> >
>> > It wouild help if you could define "breaks".
>>
>> Sorry!  It hangs during boot, before any output on the serial console.
>> I
>> got as far as working out that it hangs somewhere in
>> arch/ppc/kernel/time.c:time_init() (or one of the called functions).
>
> Er.. Didn't we talk about this awhile ago, and get a different version
> of this patch working back in 2.4?  The problem was that we couldn't use
> todc_calibrate_decr we had to still grab the value from the residual
> data.  And I thought I had kept that logic still..

Just a quick update on this.  Tom has a patch that I've tested that
makes it work again.  I very much hope it will be submitted shortly.

Thanks all for your help.

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
