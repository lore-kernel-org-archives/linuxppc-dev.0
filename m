Message-ID: <1072F1A27E99D3119747005004B9A38041575E@MAIL>
From: Rodney Davies <RodneyD@nulec.com.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Size of GLibc - Looking for smallest Glibc
Date: Tue, 28 Mar 2000 15:36:27 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings all!

Ah, would just like to ask around to find out what has been happening of
recent with respect to the size of GlibC for embedded applications, and
where it is currently up to...

Basically, what I'm looking for is, the smallest, most compact GLibC library
available (or equivalent), as for my applications with the MPC8xx work I'm
currently doing, size is a major issue. I have to keep the Flash and RAM to
an absolute minimum, so I'm investigating issues such as -

1. Kernel size
2. Actual size of the libraries
3. Size of binaries (depending on whether static/dynamically linked)
4. Issue of whether to go with Static or Dynamic linking of libraries...


So far, I've heard about "newlib" and a *very* compact version of glibc....I
was wondering if anyone could please ellaborate on these ideas/issues, let
us all know what is available, and where things stand at the moment...??

Thank-you all in advance...

Cheers,
Rod


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
