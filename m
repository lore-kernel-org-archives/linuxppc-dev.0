Subject: Re: After Uncompresseing Linux..., what's next
From: Gary Thomas <gary@chez-thomas.org>
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021220164821.77027.qmail@web41213.mail.yahoo.com>
References: <20021220164821.77027.qmail@web41213.mail.yahoo.com>
Content-Type: text/plain
Date: 20 Dec 2002 09:52:33 -0700
Message-Id: <1040403153.32282.6220.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2002-12-20 at 09:48, Prakash kanthi wrote:
> I do have xilinx tools and i am working with their V2P
> product. I completely understands what you are said.
> But the problem is, right after the uncompression and
> cpy to 0x00000000, i loose total control because i
> don't have any clue what is getting executed.
>

What sort of things can you do with the Xilinx tools?  Is
there any way to set [hardware] breakpoints or single step?

> And also, i have my boot monitor code at 0x00000000,
> before uncompress process overwrites it. I see that
> some of that code is getting executed after jump to
> 0x0. I reason i am overwriting 0x0 is because, i only
> have 8MB RAM.
>

8M should be plenty of RAM.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
