Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Dan Malek <dan@embeddededge.com>
Subject: Re: Linuxppc and MPC8255 routing performance
Date: Fri, 9 Nov 2001 12:55:29 +0300
Cc: linuxppc-embedded@lists.linuxppc.org, mercio@digitel.com.br,
	lehder@digitel.com.br
References: <9729.011107@vanet.com.br> <01110818021400.00999@scop.digitel.com.br> <3BEAFCEB.3090604@embeddededge.com>
In-Reply-To: <3BEAFCEB.3090604@embeddededge.com>
MIME-Version: 1.0
Message-Id: <01110912552900.03277@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Friday 09 November 2001 00:45, Dan Malek wrote:
> > Even without secondary (L2) cache?
>
> Yes.  Depending upon the application, using the "backside" memory
> for exclusive CPM use could be helpful.
>

By "backside" memory you mean ... the internal data cache, perhaps?

And, how can this be done?

[sorry for the silly questions, but I'm new to both Linux and MPC8255 memory
stuff :-( ; any pointer to documentation will be very welcome, too]

Thanks again...

~ Ricardo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
