Content-Type: text/plain;
  charset="iso-8859-1"
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: Mark Chambers <markc@mail.com>
Subject: Re: console problem
Date: Thu, 25 Jul 2002 21:00:58 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <5.1.0.14.0.20020719083530.00a11d50@raven-villages.net> <5.1.0.14.0.20020723145817.00a8c120@pop1.mail.com>
In-Reply-To: <5.1.0.14.0.20020723145817.00a8c120@pop1.mail.com>
MIME-Version: 1.0
Message-Id: <200207252100.58092.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Mark,

When I use the BDI2000 to find out what the board is doing, I can
see the place where the PPCBoot and Linux will hang.  As for debugging
the problem, I mentioned my conclusion in reply to another post.

Thanks for your followup!

Best regards,
-Arun.

On Tuesday 23 July 2002 03:13 pm, Mark Chambers wrote:
> Hi Arun,
>
> I've got a question about your situation:  If you have no terminal attached
> to your system, how do you know what Linux is doing?  Or to put it
> conversely, how do you know that it's failing?  Are you sure the problem is
> really related to removing the cable or do you change something else to run
> without a terminal?
>
> I have seen my code hang in the very same place - but it did it whether a
> cable was attached or not, because the UART was not set up correctly.
>
> Mark Chambers


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
