Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 7B071DE0E8
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 12:24:40 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1108864pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 19:24:39 -0700 (PDT)
Subject: Re: Warp patches for 2.6.26
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <seanm@seanm.ca>
In-Reply-To: <20080412134831.424480cf@lappy.seanm.ca>
References: <20080412134831.424480cf@lappy.seanm.ca>
Content-Type: text/plain
Date: Sat, 12 Apr 2008 21:24:34 -0500
Message-Id: <1208053474.5869.46.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-04-12 at 13:48 -0400, Sean MacLennan wrote:
> I was going to hold off until the warp was officially released, but we
> might miss the merge window. So here they are. A lot of work has been
> done since 2.6.25 and I haven't been submitting patches to keep down on
> the churn.

That's fair enough.  And from what I can tell, your patches are fairly
localized to your platform.  So once they get some initial review and
fixing, I don't foresee having too much trouble getting them merged.

One thing to keep in mind though, is that the closer we get to the merge
window, the tighter I get on what new stuff I'll bring in for the next
release.  This may seem counter-intuitive, but I like to have the merge
window really be for testing out and fixing any issues that pop up
during the merge of all the various subsystem trees.  You'll also want
to add in some lead time for patch review, etc.

That's a long winded way of saying "release early, release often" I
suppose :).

josh
