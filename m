Message-ID: <1275.80.7.99.14.1077957786.squirrel@www.solinno.co.uk>
In-Reply-To: <20040228003259.3dd5c25a.akpm@osdl.org>
References: <1180.80.7.99.14.1077956583.squirrel@www.solinno.co.uk>
    <20040228003259.3dd5c25a.akpm@osdl.org>
Date: Sat, 28 Feb 2004 08:43:06 -0000 (GMT)
Subject: Re: Please revert "use todc time functions for PPC_PREP" changeset
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Andrew Morton" <akpm@osdl.org>
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew Morton said:
>
> "Leigh Brown" <leigh@solinno.co.uk> wrote:
>>
>> Hi Tom,
>>
>>  Your patch (ChangeSet@1.1557.41.25) breaks the 43p140 and Carolina, and
>>  probably quite a few other RS/6000 based PRePs.  I was a bit surprised
>>  to see it 2.6.3.
>>
>>  http://linux.bkbits.net:8080/linux-2.5/patch@1.1557.41.25?nav=index.html|ChangeSet@-3w|cset@1.1557.41.25
>>
>>  Can we revert this until there is a working version, please?
>
> It wouild help if you could define "breaks".

Sorry!  It hangs during boot, before any output on the serial console.  I
got as far as working out that it hangs somewhere in
arch/ppc/kernel/time.c:time_init() (or one of the called functions).

I can do some more narrowing down if it helps.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
