Date: Thu, 28 Feb 2002 08:28:24 -0500
Subject: Re: jdk 1.4?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: linuxppc-dev@lists.linuxppc.org
To: rshapiro@bbn.com
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
In-Reply-To: <15482.32063.537466.19280@esb.bbn.com>
Message-Id: <0A961C64-2C4F-11D6-9A4A-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

To answer you question.  Don't hold your breath.  I simply don't have
the time to work on it and it has not even been released yet.  Once it
gets released I (or some other volunteer) will try and get a version
working.  Note, we do not have hotspot (yet) and the entire jdk 1.4 no
longer support classic threading, so we have to backport and fix it from
jdk 1.3.x.

This will actually take some time that I simply don't have to give.  If
you would like to join Blackdopwn and help out, that would be greatly
appreciated.

I am simply tired of asking for "volunteers" that never work on things
and never help.

If you or someone you know would really like to help, I would greatly
appreciate it.  Please note, the IBM jdk 1.3.X with JIT is out there and
available from SuSE and from IBM.

Kevin

On Monday, February 25, 2002, at 01:06 PM, R Shapiro wrote:

>
> What's the status of jdk1.4 for ppc linux? A project I'm working on is
> very eager to switch from 1.3 to 1.4 (all the othe developers are
> running intel linux or nt/2000).  Since last Fall I've been running
> darwin/osx but it looks like Apple won't have a 1.4 release for quite
> some time.  Is ppc linux likely to have a working version soon?
>
> Please cc me directly on any replies.
>
> Thanks -
>
> --
> rshapiro@bbn.com
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
