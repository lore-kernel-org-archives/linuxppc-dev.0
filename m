Message-ID: <DD38D67B9196D31189EC00508B62563701C4921F@zro01exm01.corp.mot.com>
From: Diaconescu Bogdan-BDIACON1 <bogdan.diaconescu@motorola.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Gcc longcall option
Date: Tue, 22 Jul 2003 18:34:06 +0300
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi guys,

I have a question not strictly related to kernel but more related to
gcc and it's options.

I try to create a big exe image (around 800M with symbolics) using
gcc-2.95.x and I run into the problems of relative branch addressing
which has only 24 bits for PPC. I know if I use some __atribute__
((longcall)) for function prototypes the addressing is done through LR
so it's changed to indirect branch. I was looking for options like
-mlongcall or -mlong-calls but it seems they don't exist for PPC.

Now the question: do you know a distribution in which gcc is having
such options or do you know another way to get the link done with the
big exe image I have?

Regards,
Bogdan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
