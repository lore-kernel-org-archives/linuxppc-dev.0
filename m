Message-Id: <5.1.0.14.0.20020723145817.00a8c120@pop1.mail.com>
Date: Tue, 23 Jul 2002 15:13:49 -0400
To: Arun Dharankar <ADharankar@ATTBI.Com>
From: Mark Chambers <markc@mail.com>
Subject: Re: console problem
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200207211506.57760.ADharankar@ATTBI.Com>
References: <5.1.0.14.0.20020719083530.00a11d50@raven-villages.net>
 <5.1.0.14.0.20020719083530.00a11d50@raven-villages.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Arun,

I've got a question about your situation:  If you have no terminal attached
to your system, how do you know what Linux is doing?  Or to put it
conversely, how do you know that it's failing?  Are you sure the problem is
really related to removing the cable or do you change something else to run
without a terminal?

I have seen my code hang in the very same place - but it did it whether a
cable was attached or not, because the UART was not set up correctly.

Mark Chambers


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
