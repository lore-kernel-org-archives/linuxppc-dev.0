To: Gabriel Paubert <paubert@iram.es>
Cc: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
References: <Pine.HPP.3.96.990217131308.26713D-100000@gra-ux1.iram.es>
From: Jesper Skov <jskov@cygnus.co.uk>
Date: 18 Feb 1999 08:44:36 +0000
In-Reply-To: Gabriel Paubert's message of "Wed, 17 Feb 1999 13:19:31 +0100 (MET)"
Message-ID: <oovhh0w16z.fsf@lassi.cygnus.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Gabriel" == Gabriel Paubert <paubert@iram.es> writes:
Gabriel> I had the impression that the APUS I/O accesses had to use
Gabriel> non byte swapped instruction, so that merging the APUS with
Gabriel> the other would be hard. Is there something I missed ?

True, APUS doesn't require byte swapping. But I don't see how this
makes it hard to integrate APUS.

Gabriel> I don't want the kernel to execute conditional code or to
Gabriel> call a subroutine for every I/O access, this is bloat and/or
Gabriel> inefficiency for the sake of it.


This is a valid concern. I don't know if it's possible to do anything
about this. 

It may be the case that none of the Amiga drivers use the same IO
macros as other drivers use. As I remember it, there are two set of
macros. But it's a long time since I looked at that, I could be wrong.

Jesper

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
