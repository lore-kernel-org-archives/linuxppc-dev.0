Content-Type: text/plain;
  charset="iso-8859-2"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: Honza Petrous <hop@unibase.cz>
Subject: Re: ppc405
Date: Tue, 5 Aug 2003 17:04:36 +0530
Cc: linuxppc-embedded@lists.linuxppc.org
References: <3rei6m2mr5lqbm8.050820030924@gda-server> <d1meaw1bmx51kfr.050820031511@gda-server> <1060080131.22522.40.camel@elrond.unibase.cz>
In-Reply-To: <1060080131.22522.40.camel@elrond.unibase.cz>
MIME-Version: 1.0
Message-ID: <mlrn6rj64aahbrw.050820031654@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
Thankx, we have tried whatever you have mention. We have disabnled the "X"
and we are getting this in text mode only. Can you pl suggest us any browser
which uses any embedded graphics libraries. We dont want to use X11.

Thanks & Regards,

Rakesh Jagota
On Tuesday 05 August 2003 04:12 pm, Honza Petrous wrote:
> V Út, 05. 08. 2003 v 11.51, Rakesh jagota napsal:
> > Thanks a lot. It seems X11 is required for this browser.
> > Is there any browser without X11 libraries.
>
> See more deeply in configure.sh - there is possibility
> to not use X at all ;) Then it will act in full-screen
> textmode only.
>
> /Honza
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
