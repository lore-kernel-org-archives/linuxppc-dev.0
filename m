Message-ID: <762A181C0D966E459A2EB3B810142C7703861526@nmrusdunsx12.nmrlan.net>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'Mark Chambers'" <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux is not reliable enough?
Date: Tue, 27 Jul 2004 10:41:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark,

A couple of comments on your comments (sorry for keeping this going).

> One point I was trying to make is that assuming the underlying hardware
> is good, all software is theoretically perfect.

I can't imagine this statement being true.  It's true that if the hardware
is bad, the software may not operate correctly, but the converse isn't true.
The following code is incorrect, regardless of the state of the hardware it
runs on:

  int a[100], b = 123;
  a[b] = 0;

I guess I'm taking exception to your use of the phrase "all software".


> That is, given the same set of input conditions it will always produce
> the same output.

If ...

0. Asynchronous interrupts are enabled, or
1. Your code reads an A/D converter and acts on that data, or
2. Your code acts on operator input, or
3. One of several other normal situations hold,

then this statement, while true, just doesn't apply. In my experience,
real-world situations that allow the assumption of software determinism
are remarkably rare.


Ultimately what were talking about here is: who has to be convinced of
the reliability of the chosen OS?  I personally spent many years
designing and deploying hospital-grade medical monitors.  If human
life is at stake, there are regulatory agencies looking over your shoulder.

In the medical business, there is our own FDA as well as a number of other
agencies (including the German TUV (IMHO the toughest taskmaster of
them all)).  You simply aren't going to sell your device until you get
approval from the appropriate regulatory agency. It is the regulatory
agencies you need to convince.

What the agencies are looking for in your submission for approval to
sell your device is extensive test data that your company is willing
assert is accurate and that demonstrates this reliability.  This is
a huge task.  So, what you do is "pass the buck."  You find a vendor
of a commercial OS that already has done this testing and you include
their test data (and their assertions) in your submission to the
regulatory agencies.


I suppose I've wandered a bit off-topic here, but it seemed relevant.

Regards,
Charlie


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
