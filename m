Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.180])
	by ozlabs.org (Postfix) with ESMTP id A15FADDE42
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Nov 2007 01:57:23 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id r27so256669ele
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 02 Nov 2007 07:57:22 -0700 (PDT)
Message-ID: <fa686aa40711020757y7591ce1eh3902f1856f254e3e@mail.gmail.com>
Date: Fri, 2 Nov 2007 08:57:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: khollan <khollan@daktronics.com>
Subject: Re: serial GDBServer PPC405 problems
In-Reply-To: <13548781.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <13532592.post@talk.nabble.com>
	<200711020944.53077.wangbj@lzu.edu.cn> <13548781.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/2/07, khollan <khollan@daktronics.com> wrote:
>
>
> Wang, Baojun wrote:
> >
> >
> >
> > Your kernel don't have kgdb support? then you need a debugger like bdi2000
> > to
> > debug the kernel.
> >
> > Wang
> >
> >
> Do I need to add kgdb even if I just want to debug a user application over
> serial?

No you don't.  gdbserver is the right tool.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
