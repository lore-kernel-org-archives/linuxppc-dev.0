Message-ID: <F14441D40E5AD3118886005004607AD10BDD3E@mail.libra.de>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: "'Vladimir Simonov'" <sv@asplinux.ru>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: AW: OF access after kernel boot
Date: Tue, 4 Jul 2000 10:17:30 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi all,
> I'd like to change some OF (Open Firmware)
> parameters after kernel loading.

You can set the variables stored in nvram by acessing
/dev/nvram. There is a tool nvsetenv that allows setting
of such variables. I hope paul has incorporated some changes,
so it will run on new world machines, too (which have a different
nvram layout.)

BenH and others told me, that the OF interpreter cannot be reactivated
after some other OS has taken control (that would be a cheap way
to have a forth interpreter at hand :)

Greetings ,

|       |                  Klaus Halfmann       khalfmann@libra.de
|       |
|    i  | --.  r---  -- |  Libra Software GmbH  Tel +49 (0)621 41997-0
|    |  b-- |  |    a-- |  Erzbergerstr. 17     Fax +49 (0)621 41997-30
L--- |  --- |  |    .---.  68165 Mannheim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
