Message-ID: <E380A44D523BD5118EAE0002A52CE5C40B87C888@zcard0k8.ca.nortel.com>
From: "Andrew Williams" <awilliam@nortelnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: FW: Code Clean-Up
Date: Mon, 26 Apr 2004 14:50:24 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Re-send due to outlook HTML formatting issues...


-----Original Message-----
Sent: April 26, 2004 10:52 AM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Code Clean-Up


What's the current view/policy on code cleanup?
Eg. immap_8260.h vs 8xx_immap.h

  Furthermore each unit that accesses the immap, has to conditionaly select
the target platform header file.

I'm proposing a single immap.h file, that conditionaly selects either
immap_8260.h, or 8xx_immap.h (possibly renamed to immap_8xx.h).

  Do people want to see this type of restructure/patch?

Andrew

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
