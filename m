Message-ID: <1280.80.7.99.14.1077957945.squirrel@www.solinno.co.uk>
In-Reply-To: <1077956929.23344.98.camel@gaston>
References: <1180.80.7.99.14.1077956583.squirrel@www.solinno.co.uk>
    <20040228003259.3dd5c25a.akpm@osdl.org>
    <1077956929.23344.98.camel@gaston>
Date: Sat, 28 Feb 2004 08:45:45 -0000 (GMT)
Subject: Re: Please revert "use todc time functions for PPC_PREP" changeset
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "Andrew Morton" <akpm@osdl.org>,
	"Tom Rini" <trini@kernel.crashing.org>,
	"linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt said:
> On Sat, 2004-02-28 at 19:32, Andrew Morton wrote:
>> "Leigh Brown" <leigh@solinno.co.uk> wrote:
>> >
>> > Hi Tom,
>> >
>> >  Your patch (ChangeSet@1.1557.41.25) breaks the 43p140 and Carolina,
>> and
>> >  probably quite a few other RS/6000 based PRePs.  I was a bit
>> surprised
>> >  to see it 2.6.3.
>> >
>> >  http://linux.bkbits.net:8080/linux-2.5/patch@1.1557.41.25?nav=index.html|ChangeSet@-3w|cset@1.1557.41.25
>> >
>> >  Can we revert this until there is a working version, please?
>>
>> It wouild help if you could define "breaks".
>
> Yup, Leigh, we have at least a week I suppose before 2.6.4 goes final, so
> we can probably fix the problem rather than reverting the cleanup.
>
> Can you tell us more about what's going on ?

Okay, great.  I have to go out now but I'll narrow down the exact function
that's hanging when I get back.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
