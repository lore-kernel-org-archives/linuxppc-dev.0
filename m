Message-ID: <64885.213.107.143.228.1049136124.squirrel@www.solinno.co.uk>
Date: Mon, 31 Mar 2003 19:42:04 +0100 (BST)
Subject: Re: [PATCH] Fix memory size not being passed to kernel from prep boot loader
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <trini@kernel.crashing.org>
In-Reply-To: <20030327202554.GH31771@ip68-0-152-218.tc.ph.cox.net>
References: <63228.213.107.143.228.1048441818.squirrel@www.solinno.co.uk>
        <20030327201313.GG31771@ip68-0-152-218.tc.ph.cox.net>
        <20030327202554.GH31771@ip68-0-152-218.tc.ph.cox.net>
Cc: <paulus@samba.org>, <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini said:
> On Thu, Mar 27, 2003 at 01:13:13PM -0700, Tom Rini wrote:
>>
>> On Sun, Mar 23, 2003 at 05:50:18PM -0000, Leigh Brown wrote:
>>
>> > Current linuxppc_2_4 doesn't work on my 140 because the boot loader
>> isn't passing in the memory size.  This patch fixes that.
>>
>> Paul broke it in the massive merge of other PReP changes.  Can you try
>> just adding the BI_MEM_SIZE record code in?  The rest of those changes
>> should be superfluous.  Thanks.
>
> Ah, I think not.  How about the following patch?  I didn't want to
> remove the 'residual = hold_residual' line due to SMP things
> referencing both.  Troy, can you explain why it's not consistenly
> referencing 'hold_residual' ?

It works, anyway.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
