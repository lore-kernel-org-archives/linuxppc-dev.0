From: sam@ravnborg.org
MIME-Version: 1.0
To: Matevz Langus <matevy@arhitektova-delavnica.com>
Subject: Re: Efficient handling of RTP frames?
Reply-To: sam@ravnborg.org
Cc: linuxppc-dev@lists.linuxppc.org, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <20040511214243.A2ED715C57@post1.dk>
Date: Tue, 11 May 2004 23:42:43 +0200 (CEST)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tir, 11 May 2004 10:28:02 +0200 skrev Matevz Langus <matevy@arhitektova-delavnica.com> :

>Hi,
>
>I did the following in advance to all others said before:
>left UDP CRC field empty, so you don't need to calculated CRC. VoIP
>systems do not complain about that.
Thanks for this tip, unfortunately we already use this 'feature'.

We are operating with 5 ms samples so we need to be very careful about any overhead (present implementation is running in a VxWorks environment).

   Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
