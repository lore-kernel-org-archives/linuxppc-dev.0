Message-ID: <37C103E7.F59F140A@sxb.bsf.alcatel.fr>
Date: Mon, 23 Aug 1999 10:18:47 +0200
From: Francois Kleitz <francois.kleitz@sxb.bsf.alcatel.fr>
MIME-Version: 1.0
To: damm@kieraypc01.p.y.ki.era.ericsson.se, Pierre_Juste@email.mot.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: anti-crash patch
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, Pierre, Magnus,

Maybe the things are linked.
I already read of such patch, and even more complicated ones. They all
aim at freezing some TLBs to account for internal register space (in
suggestion you forwarded, Magnus) and sometimes for more space (for
others I remember but can't find reference to anymore). I think this is
only half satisfying, because these solutions only avoid TLB misses;
this means avoiding the symptom to manifest itself, not curing the
disease.

What do you think ? How is it that the MBX does not experience the
problem ? Maybe there is something here to find ?

Thank you for advertising any solution...

Francois

--
  Francois KLEITZ
  Phone  :  (33) 3 88 67 78 21
  Fax    :  (33) 3 88 67 74 71
  E-mail : francois.kleitz@sxb.bsf.alcatel.fr


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
