Message-Id: <200105032145.QAA05255@lists.linuxppc.org>
Date: Thu, 3 May 2001 17:45:47 -0400
From: Scott Hankin <shankin@rational.com>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
To: Linux PPC Developers <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0 (Apple Message framework v388)
Subject: Re: 2.4.5-pre1 hangs on Wallstreet
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thursday, May 3, 2001, at 03:39  PM, Scott Hankin wrote:

> I built the latest bk tree this morning after rsyncing, and on boot, I
> only get the initial black screen, then it stops.  No dump, no monitor,
> no nothing.  Where do I go from here?

An update:  it hangs after printing out the "MMU: exit" message.  On my
2.4.4 kernel, it goes on to tell me "xmon uses screen and keyboard" on
the next line, but on 2.4.5-pre1, it just stops.
Any clues?

- Scott

-----------------------------
Scott Hankin (shankin@rational.com)  In the beginning, there was
nothing, then
Rational Software                    God said, "Let there be light."
And there
20 Maguire Road                      was light.  There was still
nothing, but
Lexington, MA 02421                  you could see it a lot better.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
