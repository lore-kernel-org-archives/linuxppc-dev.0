Message-ID: <20000320100508.5947.qmail@web110.yahoomail.com>
Date: Mon, 20 Mar 2000 02:05:08 -0800 (PST)
From: Michel "D?nzer" <mdaenzer@yahoo.com>
Reply-To: michdaen@iiic.ethz.ch
Subject: Re: XFree4 w rage128
To: georges Harrisson <georges.harrisson@caramail.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- georges Harrisson <georges.harrisson@caramail.com> wrote:
> I am sorry to ask a question that must have been answered
> in the billions of messages talking from XFree 4, but is it
> possible to run it actually with the r128 driver ?

Yes.


> On my BW G3, when I launch X I get hundred of lines like
> :
> (W) r128: resolution deleted (XXX x XXX)
> (E) r128: no available mode found
> No screen found

You either haven't specified valid modes for your monitor or the correct
horizontal and vertical frequency ranges.


> I am running on anthony's aty128fb.

Do you use Option "UseFBDev" ?


> When I use offb, it goes a step further and crashes with a segmentation
> fault.

I wouldn't expect that to work anyway...


> What is wrong with it? What are the necessary patches for
> XF4 to work on PPC?

None except the cache flush patch by Kostas Gewrgiou and Kevin Hendricks.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
