From: Jesper Skov <jskov@cygnus.co.uk>
Message-ID: <14028.8989.97786.951216@lassi.cygnus.co.uk>
Date: Thu, 18 Feb 1999 14:26:37 +0000 (GMT)
To: Gabriel Paubert <paubert@iram.es>
Cc: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <Pine.HPP.3.96.990218144506.482S-100000@gra-ux1.iram.es>
References: <oovhh0w16z.fsf@lassi.cygnus.co.uk>
	<Pine.HPP.3.96.990218144506.482S-100000@gra-ux1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Gabriel" == Gabriel Paubert <paubert@iram.es> writes:

>>  This is a valid concern. I don't know if it's possible to do
>> anything about this.
>> 
>> It may be the case that none of the Amiga drivers use the same IO
>> macros as other drivers use. As I remember it, there are two set of
>> macros. But it's a long time since I looked at that, I could be
>> wrong.

Gabriel> No they don't, have a look at include/asm-ppc/io.h, there is
Gabriel> a lot of ifdef on CONFIG_APUS. This can't reasonably be made
Gabriel> into a run time option IMHO.

I'm aware of having made those changes :)   What I'm not sure about is
whether I experienced problems with both read/writex and in/outx, or
just did the conversion wholesale. 

What I'm considering is whether it would be possible to use the _ns
variants in Amiga drivers -- which is quite likely. Then you could
swap bytes to your heart's content in the other macros for all I care.

Jesoer

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
