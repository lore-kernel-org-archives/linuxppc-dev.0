Message-ID: <023401c14a68$96467a60$7e7e7e7e@server>
From: "RSR - Piero Dominioni" <pdominioni@rsr.it>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <F1BED55F35F4D3118C0F00E0295CFF4D414C19@mail.mediatrix.com>
Subject: R: NFS mount for TQM823L
Date: Mon, 1 Oct 2001 13:02:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I need your help anymore:

< You need the portmapper (portmap), NFS daemon (rpc.nfsd), NFS mount daemon
< (rpc.mountd).
< All this comes from the standard NFS control script.
< Refers to the nfs-utils package (http://sourceforge.net/projects/nfs/)
< in the script file 'etc/nodist/nfs-server'.

I downloaded the nfs-utils-0.3.3.tar.gz, compiled for pc and used the
portmap daemon obtained this way on my Slackware 7.2 Linux box
(The executable file is quite double in dimensions respect the one
installed and temporarily substituted on my Linux box).
Everything works fine.

Then I cross-compiled it and, since I didn't well understand what to do
with the nfs-server script, I used nfsd and mountd found under
nfs-utils-0.3.3/utils/nfsd/  (.../utils/mountd/).
I transferred these three files on my target (TQM823L) via ftp, then:
# chmod 755 portmap     // the same for nfsd and mountd
# ./portmap
# ps aux
I can see that portmap is suspended: I guess it is correctly waiting for
RPC calls and for other daemons (such as mountd and nfsd) to register.

But if I try to run mountd or nfsd (# ./mountd,  for example) I get the same
errors as portmap wouldn't be running at all.
Why? What should I do anymore?

< I'm not sure, but you may also need the remote quota server (rpc.rquotad).
< Of course, you should have a valid /etc/exports file.

I didn't try quotad: if mountd and nfsd don't run maybe it wouldn't too...

< You can even use it directly to start the NFS server.

Can you explain me how?
Should I cross-compile it for my PowerPC platform, load it on the targe
and then run it?

Thank you very much for your patience.

Best regards

Piero Dominioni
R.S.R. srl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
