Date: Fri, 10 Mar 2000 16:03:57 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.15pre11 on PB Lombard
In-Reply-To: <Pine.SOL.3.95.1000309182200.26688A-100000@juliet>
Message-ID: <Pine.SOL.3.95.1000310155822.28663B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 Mar 2000, Derek Homeier wrote:

>
> I also noticed that power consumption during sleep had dramatically increased
> with the previous 2.2.15pre kernels; I'm currently checking out if that problem
> persists.
>
Seems as it is still there, the battery is discharged by approx. 40% during
24 hours of sleep w/ 2.2.15pre11, while it used to be ~10%. I think it was
even more (>60%) with 2.2.15pre3-7. Has anyone else seen this?
The sound module was unloaded and the CD drive empty.

							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
