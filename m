From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Tue, 26 Mar 2002 11:05:06 +0100
Message-Id: <20020326100507.5228@smtp.adsl.oleane.com>
In-Reply-To: <20020325191616.J24258@boardwalk>
References: <20020325191616.J24258@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On Sun, Mar 24, 2002 at 05:46:49PM +0100, Benjamin Herrenschmidt wrote:
>>
>> Of course you want to add whatever additional bi_recs, and among the things
>> I propose is the definition that the kernel will only use all-lowercase
>> bi_rec types for it's own use leaving any other combo for other uses.
>
>Did you mean, the kernel will use all-uppercase bi_rec types?  That's
>what it's currently using.  If you meant to say that the kernel will
>use all-lowercase bi_rec types, I'm interested in knowing why it's
>worth breaking backwards compatibility.

Yes, sorry for the confusion.

>> No. A BI_IGNORE makes no sense. A whole class of bi_rec types guaranteed
>> not to be used by the kernel makes sense.
>
>Sure, that makes sense.  Like the vendor specific major/minor numbers.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
