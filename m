Message-ID: <012501c15257$52a964b0$7e7e7e7e@server>
From: "RSR - Piero Dominioni" <pdominioni@rsr.it>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <F1BED55F35F4D3118C0F00E0295CFF4D414C39@mail.mediatrix.com>
Subject: R: NFS mount for TQM823L
Date: Thu, 11 Oct 2001 15:15:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 3) You may also start the syslog daemon, to be sure you don't miss
important
> information.

Dear Jean-Denis,
this above has been the key suggestion that lead me to success!!!
Finally we could remote-mount our target's file system
under whatever host (not every one, really) in our local network!
Without the syslogd daemon I couldn't have been able to
discover that the 'etab' file was missing in /var/lib/nfs target's
directory.
I don't know the rule or the meaning of all the lines and keywords
that are in this file: I would like to know ,  in addition to the
capability to make them run...
Who does create this file, on the hosts for example?
 Which command or daemon?
I add here another pair of question, that would complete the
scene.

> 1) Does it produce a core file?
What do you mean with 'core file'?

> 2) You may start mountd with the following options:
>    mountd --debug all --foreground
>   This will start mountd in foregroud, turning on debugging information.
>    I hope it will help...
How should I have debugged then? (I couldn't do it)
I have seen nothing: should any message have appeared?

At last I want to thank you very much for your precious help, and
I hope that our correspondence could help somebody else.

Best regards

Piero Dominioni
R.S.R. srl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
