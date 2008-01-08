Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 47484DDF46
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:49:28 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1556513anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jan 2008 16:49:28 -0800 (PST)
Message-ID: <3ae3aa420801071649w6a8d3939y176dc389d68f4870@mail.gmail.com>
Date: Mon, 7 Jan 2008 18:49:27 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 3/8] pseries: phyp dump: reserve-release proof-of-concept
In-Reply-To: <200801080126.51897.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4782C1A8.3050804@austin.ibm.com>
	<200801080126.51897.arnd@arndb.de>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	strosake@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 07/01/2008, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 January 2008, Manish Ahuja wrote:
>
> > Initial patch for reserving memory in early boot, and freeing it later.
> > If the previous boot had ended with a crash, the reserved memory would contain
> > a copy of the crashed kernel data.
> >
> > Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
>
> I think the signed-off-by chain needs to be modified. The way it appears,
> you handled the patch first, then sent it to Linas, who forwarded it
> to whoever will take the patches from the list.

Well,
-- there was dual authorship. I remangled the patches while Manish wrote
code & tested. And I'd mailed them out the first time around, so you could
say I forwarded after heavy editing.


> This obviously isn't true, since you are actually the one who is sending
> out the patches. Moreover, I believe that the linas@austin.ibm.com
> address is now dead, and shouldn't be used for this any more.

Hmm. I wanted to indicate that the work was done while I was at IBM;
clearly, no one is going through git and changing old, expired email
addrs, and so submission based on the old addr seemed appropriate.

I'm taking the Signed-off-by line as a quasi-legal thing: a fancy ID string,
identifying the author(s),  rather than a new way to manage email
address books.

> So, depending on which of you two wrote the majority of a patch, I think
> it should be either

I'm not sure there was a clear majority. I think Manish did more work
in general, but we hacked this together side by side. I got him to create
working tested code; I busted it up into individual, clean, documented,
mailing-list ready chunks.

--linas
