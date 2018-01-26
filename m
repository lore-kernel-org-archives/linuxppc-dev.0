Return-Path: <frowand.list@gmail.com>
Received: from mail-pg0-x229.google.com (mail-pg0-x229.google.com
 [IPv6:2607:f8b0:400e:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSKrJ6JDLzF0Qn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 11:42:56 +1100 (AEDT)
Received: by mail-pg0-x229.google.com with SMTP id w17so6169859pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 16:42:56 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 devicetree@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <ac4f02e1-6d49-158a-4fb6-56ac0d474a44@gmail.com>
 <20180122114948.mm5mg6zqw3hmjj4o@katana>
 <11cf8fac-d2fe-ecdb-546f-de3c3b42a637@gmail.com>
 <20180125231219.mkgai2yurkj3f7ph@ninjato>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <b4396070-accc-1fe2-21a6-cefaddeeb06c@gmail.com>
Date: Thu, 25 Jan 2018 16:42:51 -0800
MIME-Version: 1.0
In-Reply-To: <20180125231219.mkgai2yurkj3f7ph@ninjato>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/18 15:12, Wolfram Sang wrote:
> Frank,
> 
> here seems to be a misunderstanding going on. I don't want to push this
> patch upstream against all odds. I merely wanted to find out what the
> status of this patch is. Because one possibility was that it had just
> been forgotten...
> 
>>> So, I thought reposting would be a good way of finding out if your
>>> concerns were addressed in the discussion or not. If I overlooked

Marking a patch as RFC (as you mention just below here) is very different
than explicitly stating something like: Frank, you had concerns with
version 1, were your concerns addressed in the thread about version 1?

You mention below that adding RFC to the title was providing the
information that I needed.  I am saying that the communication was
not clear, was implied at best, and should have be more explicit.

I actually didn't even notice that the patch title had changed from
not an RFC, to being an RFC, so the subtle clue went right over my
head.  I just treated it as I would any RFC patch.


>> Then you should have stated that there were concerns raised in the
>> discussion and asked me if my concerns were addressed.
> 
> From my perspective, I have done that:
> 
> I marked the patch as RFC. I put you on the CC list. I asked about the
> possibility of applying it. It was not very elaborate, but hey, this is
> just a simple debugging patch :)

After reading through the original patch thread, I did not think that
the issues raised had been fully addressed.  You read the thread and
thought they had.  No big deal on coming to different conclusions.

I think you and I are talking past each other a little bit.  My
comments in the email you are responding to are because I don't
think that the previous emails have been as clear as you think.
I could read between the lines and see how you think that you
were being clear.  But from my perspective, I'm asking for more
explicit statements and less implied statements.

My first real response (the response that pointed out that Rob had
made an observation / suggestion that was not responded to) was coming
from the perspective that the issues in the first thread had not been
fully addressed.

As I was writing that response, I felt that I might as well do a review,
even though I thought the previous thread was dangling.  Which led to a
lot of issues and a few more emails pointing them out.


> I totally would have accepted a high level "No, that won't fly
> because...". Or a high level "This and that would need a change". Or
> something like that. I intentionally sent this out as RFC because I know
> there is some testing missing. I wanted to know if it is worth taking
> further steps with this patch.
> 
> So, I simply wanted to know if you (still) have fundamental issues with
> the patch?

It would have been good if you had simply stated so in exactly those
words.  I did not read the original email as saying that.  I read
the original email as saying (my paraphrase) "please apply it".  You
did _not_ use the words that I paraphrased, you actually said
"So what about applying it?".  I misunderstood what you were trying
to say.  I apologize for that.


> That needs to be discussed first before we go into coding
> details. I think it is fine to not apply it if there are reasons. I'd
> like to know them, however, for a better understanding.

Too late now. :-)  I've already done the reviewing and provided all
of the reasons that are show stoppers for the patch and how to fix.

One thing that I did not mention in this thread  is that I have an
aversion to using ftrace for what is purely debugging data (which
this is) because there is a danger that trace points become user
space ABI.  That is a whole long discussion that we do not have to
have because I am not subjecting this patch to that objection.


> For me, this is a super-super-side project, so if it causes too much
> hazzle, I just leave it here and know interested people can find it
> easier now. But if it could be applied with a sane amount of effort, I
> was offering that.
> 
> Was that understandable?

I think so.  And in return?  We can always talk more at the next
conference if you want.

-Frank

> 
> Kind regards,
> 
>    Wolfram
> 
