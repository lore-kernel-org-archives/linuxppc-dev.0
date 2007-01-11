Return-Path: <martineschen@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id 3A4BFDDE39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Jan 2007 04:58:24 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 57so409981wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 09:58:22 -0800 (PST)
Message-ID: <3acfce80701110958n8c621bao116eb144697f383e@mail.gmail.com>
Date: Thu, 11 Jan 2007 15:58:21 -0200
From: "Daniel Martineschen" <martineschen@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: MPC5200 + boa webserver + CGI + broken pipe
In-Reply-To: <20070111011530.8091635264F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3acfce80701100307o18a24b37q616bb0c8ec4086dd@mail.gmail.com>
	<20070111011530.8091635264F@atlas.denx.de>
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

On 1/10/07, Wolfgang Denk <wd@denx.de> wrote:
> In message <3acfce80701100307o18a24b37q616bb0c8ec4086dd@mail.gmail.com> you wrote:
> >
> > > This is most probably a hardware issue (bad SDRAM initialization?)
> >
> > yes, but why does it happen only when we use the boa webserver? when
>
> Probably because this causes a specific load pattern  which  triggers
> the problem.

hmm.. this problem with "broken pipes" only occur when there are too
many concurrent accesses to a CGI script, which communicates to
another application.
but, the system only freezes when we stop and re-start the webserver.
so, could be this CGI script causing all the trouble (by starting and
dying and leaving traces/ perfoming this "load pattern") ?

> Is this a Rev. B CPU? Are you using current code? For example, do you
> perform the required SDelay initialization (AN3221) ?

no, it's not Rev. B. we wanted to use it but we had some compatibility
problems.


regards

-- 
---
Daniel Martineschen
http://www.inf.ufpr.br/danielm
