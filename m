Message-Id: <l03130306b3aae2305b88@[10.1.1.46]>
In-Reply-To: 
 <Pine.LNX.3.96L.990708160307.5641B-100000@unix47.andrew.cmu.edu>
References: <199907082014.PAA19744@www2.tuckeris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 8 Jul 1999 16:19:07 -0700
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        "Charles A. Jolley" <charles.jolley@zeratec.com>
From: Deirdre Saoirse <dsaoirse@linuxcare.com>
Subject: Re: QuickTime Streaming Server for Linux.. on x86
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:09 PM -0400 7/8/99, Hollis R Blanchard wrote:
>On Thu, 8 Jul 1999, Charles A. Jolley wrote:
>> Changing the single ticks to quotes will most definitely introduce errors,
>> though, because that will cause the compiler to produce a 32-bit pointer to
>> a NULL terminated string "frac", rather than a 32-bit value equal to the
>> four characters 'frac'.  This can be particularly deadly in code where types
>> are explicitly cast because it is still a 32-bit value either way.
>
>Just hoping for a quick fix... =)

Try treating the four-char constant as a four-byte integer instead. That's
really how it's represented in the MacOS. :)

Think of it as an undotted quad. :)


Deirdre Saoirse, Systems Analyst, Linuxcare, Inc.
415.354.4878 x252 tel, 415.701.7457 fax
dsaoirse@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
