From: Jesper Skov <jskov@redhat.com>
Message-ID: <14497.10211.826197.998721@thinktwice.zoftcorp.dk>
Date: Wed, 9 Feb 2000 09:40:03 +0100 (CET)
To: Peter Allworth <linsol@zeta.org.au>
Cc: Jesper Skov <jskov@redhat.com>, linuxppc-embedded@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: more Re: Low memory problems in 8xx Linux
In-Reply-To: <38A0BED6.AD2E336C@zeta.org.au>
References: <20000201235813.4F5611B51A@elph.research.canon.com.au>
	<38977960.40E014A1@zeta.org.au>
	<ot1z6of1ws.fsf@thinktwice.zoftcorp.dk>
	<38A0BED6.AD2E336C@zeta.org.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Peter" == Peter Allworth <linsol@zeta.org.au> writes:

Peter> Jesper Skov wrote: <snip>

>> An alternative and slighly faster implementation might be to skip
>> the _PAGE_PRESENT check. Any reason something like this wouldn't
>> work?

Peter> <snip>

Peter> I had another look at the code and I now remember my rationale
Peter> for the _PAGE_PRESENT test. It wasn't to do with level 1 table
Peter> entries, Dan's code already takes care of that. It was so that
Peter> a zeroed pte couldn't get changed to a non-zero value, since
Peter> that would make the pte_none() function return the wrong
Peter> result. (Moreover, it just seemed wrong to mess with something
Peter> that's marked "invalid".)

Peter> Admittedly I'm being a bit paranoid since the next thing the
Peter> exception handler is likely to do is set the page table entry
Peter> to something valid.  But, can you be sure? What about a
Peter> segmentation fault? ;)

No, sounds sensible.

Jesper

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
