Message-Id: <199904031910.TAA00349@Taygeta.gom.dorm.org>
Date: Sat, 3 Apr 1999 19:10:50 +0000 (Local time zone must be set--see zic manual page)
From: Guillaume Laures <GoM@Taygeta.gom.dorm.org.cybercable.fr>
Subject: i128 console drivers
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm in the planning of thinking of how I could try to... write a imagine
128 driver.
Basically I have a Mactell Vision 3D ProII Lite that I'd like to see supported,
first in the console, later in the XFB architecture (Raah cool GL  !).

First I picked the drivers in XFree 3.3.3.1, and saw they was suitable
for i128 first and second generation as well as for the Revolution 3D
card (Ticket2Ride, Mactell... in the powermac world) so why not make a
generic i128 driver ?

Then I need pointers on the functions that need to be implemented
in the console driver, I think looking at the other drivers won't be
easy.

And I need testers of course, I may won't be able to try this out by
myself (lack of a 2nd pci machine, I need my 8600 to be on 24/24, and I
don't think a module could be used here).


Thank to anybody who may help... at his level.



-- 
---
Guillaume Laurès laures@esiea.fr


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
