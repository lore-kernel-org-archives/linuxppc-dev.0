Message-Id: <199908051503.JAA31292@carboncode.com>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: kapm: PowerBook G3 Power Management?
Date: Thu, 5 Aug 1999 11:11:14 -0700
From: Don Lunder <speedy@carboncode.com>
In-Reply-To: <v04210105b3cf696f065c@[128.125.70.248]>
References: <v04210105b3cf696f065c@[128.125.70.248]>
Content-Type: text/plain; charset="US-ASCII"
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Right now, I am currently trying to get a grasp for the PMU setup, and get 
a working version of a dockable apm program.

Paul's work on the PMU unit has worked well for my 2400/180c, and from what 
I gather, it also works on the 3400 and original G3.  (I am actually able 
to put my computer to sleep, and awaken it back)

Currently, I'm trying to decode the info from the PMU.  Maybe if Paul or 
some one is reading they can help me out.

Going off the Charge Used value, my 2400 died at about 1515 I believe. 
Nothing close to the 6500 that Paul and his 3400 lasted to.  My Power Rate 
Consumption hovers around 160-210 depending on what I am doing.
Also, my voltage is right around 190 when charging.

How do these numbers compare to the 3400 and original G3?  I'll have to run 
some more tests to see how the PowerRate consumption affects the Charge 
Used variables, so I can get an accurate "remaining time" calculation.

I have never been able to use the Batmon program (since I've only run R5 on 
the PowerBook) so I'm not really sure how that program reacts to things 
either. But it seems that unless you completely charge the PowerBook, the 
Charge Used field remains constant, until the Battery has reached its full 
charge again.  But if you stop charging before that happens, the Charge 
Used field is still the same, this can't be correct.  I could be wrong 
here.  So, if anybody could help me decoding this information, that would 
be great!!! Then I could get a program out to those lucky 24/3400 & Orig G3 
owners.  And maybe Paul or some one will get a newer PowerBook so he can 
work his magic ;)

Thanks,

Don Lunder


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
