Message-ID: <F14441D40E5AD3118886005004607AD10BDDA5@MAIL1>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: "'linux-fsdevel@vger.kernel.org '" <linux-fsdevel@vger.kernel.org>,
        "'linuxppc-dev@lists.linuxppc.org '" <linuxppc-dev@lists.linuxppc.org>
Cc: "'flar@allandria.com '" <flar@allandria.com>,
        "'Olaf Hering'"
	 <olh@suse.de>
Subject: Status of HFS+ support
Date: Fri, 15 Sep 2000 08:45:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Today I can announce a bit of progress:

The following tools currently work (readonly):

hpmount ,hpumount, hpls, hpcd, hpcopy.

They are really fresh and propably full of bugs, but I was able
to copy a file from a HFS+ volume (my major goal). Everybody
interested can ask me about the anoymous CVS acces at Suse
(thanks once again), or even better might help me :). And
yes, It should run ox x86 linux, too. But I have no acces to
a machine to really test it. (On the other hand, which x86
linux user needs this :)

I hope Suse will either provide rsync access or even
prebuild the tools. If someone volunteers I can provide the
statically linked tools to be put on some web/ftp site.

My next short-term goals are debugging the tools and begin
writing the cache I'll need for write acces later.

P.S. could someone tell me how to join the linux-fsdevel
	List ? (or better read it offline)

Greetings,

|       |                  Klaus Halfmann       khalfmann@libra.de
|       |
|    i  | --.  r---  -- |  Libra Software GmbH  Tel +49 (0)621 41997-0
|    |  b-- |  |    a-- |  Erzbergerstr. 17     Fax +49 (0)621 41997-30
L--- |  --- |  |    .---.  68165 Mannheim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
