Mime-Version: 1.0
Message-Id: <v04220806b46780295d6d@[129.105.186.98]>
In-Reply-To: <Pine.HPX.4.10.9911190941180.5120-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.9911190941180.5120-100000@gra-ux1.iram.es>
Date: Sun, 28 Nov 1999 19:01:54 -0600
To: Gabriel Paubert <paubert@iram.es>
From: Geoff Hutchison <ghutchis@wso.williams.edu>
Subject: Re: Building Question
Cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:46 AM +0100 11/19/99, Gabriel Paubert wrote:
>Anyway, this probably means that the application has a lot initialized
>data (a few big arrays with some elements statically initialized could
>cause it but it's a wild guess). The resulting executable will be huge in
>any case (objdump --head will tell you how much you would have saved by
>looking at the size of the plt).

Thanks for your help. Fortunately it turned out to be much simpler. I 
saw someone suggest upgrading to a newer binutils for a similar 
problem and it helped. I'm now using the latest binutils RPM and 
don't seem to have any problems.

You are right that it has a lot of initialized data. It has one 
"defaults.cc" file with a large amount of static defaults. We'll 
probably discuss whether it's better to keep this or have a default 
config file load in before the user's config file.

Thanks to everyone for their help!
Cheers,

-Geoff Hutchison
Williams Students Online
http://wso.williams.edu/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
