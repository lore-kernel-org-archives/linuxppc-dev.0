Return-Path: <dan.j.williams@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by ozlabs.org (Postfix) with ESMTP id 277A4DDEE7
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 03:33:46 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w9so873057mue
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 09:33:43 -0700 (PDT)
Message-ID: <e9c3a7c20703160933m4df67620n75570f4b3d75ab45@mail.gmail.com>
Date: Fri, 16 Mar 2007 09:33:43 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
In-Reply-To: <20070316101658.61685352604@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e9c3a7c20703152255q16563803q33a5893c210634d1@mail.gmail.com>
	<20070316101658.61685352604@atlas.denx.de>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/16/07, Wolfgang Denk <wd@denx.de> wrote:
> In message <e9c3a7c20703152255q16563803q33a5893c210634d1@mail.gmail.com> you wrote:
> >
> > They are in -mm (git-md-accel.patch).  I'll review this driver and and
> > integrate it into my next push to Andrew, along with some further
> > cleanups.
>
> Thanks.
>
> We're doing some cleanup now based on the feedback we receive.
>
> What is easier for you to handle  -  a  complete  new  patch,  or  an
> incrementan  one  on  top  of  what  we  submitted  now?  (I'd prefer
> incremental, but will do whatever works better for you).
>
I can handle incremental, but I will probably fold everything together
in the patch that goes to -mm.

Check out Stacked GIT (http://www.procode.org/stgit/) when you get a
chance, it handles this situation well.

> Best regards,
>
> Wolfgang Denk
>

Dan
